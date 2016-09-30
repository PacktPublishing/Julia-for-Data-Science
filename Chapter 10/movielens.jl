using RecSys

import RecSys: train, recommend, rmse

if isless(Base.VERSION, v"0.5.0-")
    using SparseVectors
end

type MovieRec
    movie_names::FileSpec
    als::ALSWR
    movie_mat::Nullable{SparseVector{AbstractString,Int64}}

    function MovieRec(trainingset::FileSpec, movie_names::FileSpec)
        new(movie_names, ALSWR(trainingset, ParShmem()), nothing)
    end

    function MovieRec(trainingset::FileSpec, movie_names::FileSpec, thread::Bool) 
	new(movie_names, ALSWR(trainingset, ParThread()), nothing)
    end     

    function MovieRec(user_item_ratings::FileSpec, item_user_ratings::FileSpec, movie_names::FileSpec)
        new(movie_names, ALSWR(user_item_ratings, item_user_ratings, ParBlob()), nothing)
    end
end

function movie_names(rec::MovieRec)
    if isnull(rec.movie_mat)
        A = read_input(rec.movie_names)
        movie_ids = convert(Array{Int}, A[:,1])
        movie_names = convert(Array{AbstractString}, A[:,2])
        movie_genres = convert(Array{AbstractString}, A[:,3])
        movies = AbstractString[n*" - "*g for (n,g) in zip(movie_names, movie_genres)]
        M = SparseVector(maximum(movie_ids), movie_ids, movies)
        rec.movie_mat = Nullable(M)
    end

    get(rec.movie_mat)
end

train(movierec::MovieRec, args...) = train(movierec.als, args...)
rmse(movierec::MovieRec, args...; kwargs...) = rmse(movierec.als, args...; kwargs...)
recommend(movierec::MovieRec, args...; kwargs...) = recommend(movierec.als, args...; kwargs...)

function print_list(mat::SparseVector, idxs::Vector{Int}, header::AbstractString)
    if isless(Base.VERSION, v"0.5.0-")
        if !isempty(idxs)
            println(header)
            for idx in idxs
                println("[$idx] $(mat[idx])")
            end
        end
    else
        isempty(idxs) || println("$header\n$(mat[idxs])")
    end
end

function print_recommendations(rec::MovieRec, recommended::Vector{Int}, watched::Vector{Int}, nexcl::Int)
    mnames = movie_names(rec)

    print_list(mnames, watched, "Already watched:")
    (nexcl == 0) || println("Excluded $(nexcl) movies already watched")
    print_list(mnames, recommended, "Recommended:")
    nothing
end

function test_thread(dataset_path)
    ratings_file = DlmFile(joinpath(dataset_path, "ratings.csv"); dlm=',', header=true)
    movies_file = DlmFile(joinpath(dataset_path, "movies.csv"); dlm=',', header=true)
    rec = MovieRec(ratings_file, movies_file, true)

    @time train(rec, 10, 10)
end

function test(dataset_path)
    ratings_file = DlmFile(joinpath(dataset_path, "ratings.csv"); dlm=',', header=true)
    movies_file = DlmFile(joinpath(dataset_path, "movies.csv"); dlm=',', header=true)
    rec = MovieRec(ratings_file, movies_file)
    @time train(rec, 10, 10)

    err = rmse(rec)
    println("rmse of the model: $err")

    println("recommending existing user:")
    print_recommendations(rec, recommend(rec, 100)...)

    println("recommending anonymous user:")
    u_idmap = RecSys.user_idmap(rec.als.inp)
    i_idmap = RecSys.item_idmap(rec.als.inp)
    # take user 100
    actual_user = isempty(u_idmap) ? 100 : findfirst(u_idmap, 100)
    rated_anon, ratings_anon = RecSys.items_and_ratings(rec.als.inp, actual_user)
    actual_movie_ids = isempty(i_idmap) ? rated_anon : i_idmap[rated_anon]
    nmovies = isempty(i_idmap) ? RecSys.nitems(rec.als.inp) : maximum(i_idmap)
    sp_ratings_anon = SparseVector(nmovies, actual_movie_ids, ratings_anon)
    print_recommendations(rec, recommend(rec, sp_ratings_anon)...)

    println("saving model to model.sav")
    clear(rec.als)
    localize!(rec.als)
    save(rec, "model.sav")
    nothing
end

# prepare chunks for movielens dataset by running `split_movielens` from `playground/split_input.jl`
function test_chunks(dataset_path, model_path)
    mem = Base.Sys.free_memory()
    mem_model = mem_inputs = round(Int, mem/3)
    user_item_ratings = SparseBlobs(joinpath(dataset_path, "splits", "R_itemwise"); maxcache=mem_model)
    item_user_ratings = SparseBlobs(joinpath(dataset_path, "splits", "RT_userwise"); maxcache=mem_model)
    movies_file = DlmFile(joinpath(dataset_path, "movies.csv"); dlm=',', header=true)
    rec = MovieRec(user_item_ratings, item_user_ratings, movies_file)
    @time train(rec, 10, 10, model_path, mem_inputs)

    err = rmse(rec)
    println("rmse of the model: $err")

    println("recommending existing user:")
    print_recommendations(rec, recommend(rec, 100)...)
    nothing
end

