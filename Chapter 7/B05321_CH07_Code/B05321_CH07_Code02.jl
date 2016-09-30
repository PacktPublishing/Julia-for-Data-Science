
Pkg.update()
Pkg.add("ScikitLearn")
Pkg.add("PyPlot")

using ScikitLearn
using PyPlot

@sk_import datasets: (make_circles, make_moons, make_blobs)
@sk_import cluster: (estimate_bandwidth, MeanShift, MiniBatchKMeans, AgglomerativeClustering, SpectralClustering)
@sk_import cluster: (DBSCAN, AffinityPropagation, Birch)
@sk_import preprocessing: StandardScaler
@sk_import neighbors: kneighbors_graph

srand(33)

# Generate datasets. We choose the size big enough to see the scalability
# of the algorithms, but not too big to avoid too long running times
n_samples = 1500
noisy_circles = make_circles(n_samples=n_samples, factor=.5, noise=.05)
noisy_moons = make_moons(n_samples=n_samples, noise=.05)
blobs = make_blobs(n_samples=n_samples, random_state=8)
no_structure = rand(n_samples, 2), nothing

colors0 = collect("bgrcmykbgrcmykbgrcmykbgrcmyk")
colors = vcat(fill(colors0, 20)...)

clustering_names = [
    "MiniBatchKMeans", "AffinityPropagation", "MeanShift",
    "SpectralClustering", "Ward", "AgglomerativeClustering",
    "DBSCAN", "Birch"];

figure(figsize=(length(clustering_names) * 2 + 3, 9.5))
subplots_adjust(left=.02, right=.98, bottom=.001, top=.96, wspace=.05,
                    hspace=.01)

plot_num = 1

datasets = [noisy_circles, noisy_moons, blobs, no_structure]

for (i_dataset, dataset) in enumerate(datasets)

    X, y = dataset
    # normalize dataset for easier parameter selection
    X = fit_transform!(StandardScaler(), X)

    # estimate bandwidth for mean shift
    bandwidth = estimate_bandwidth(X, quantile=0.3)

    # connectivity matrix for structured Ward
    connectivity = kneighbors_graph(X, n_neighbors=10,
                include_self=false)[:todense]()
    
    # PyCall does not support numpy sparse matrices
    # make connectivity symmetric
    connectivity = 0.5 * (connectivity + connectivity')

    # create clustering estimators
    ms = MeanShift(bandwidth=bandwidth, bin_seeding=true)
    two_means = MiniBatchKMeans(n_clusters=2)
    ward = AgglomerativeClustering(n_clusters=2, linkage="ward",
                                   connectivity=connectivity)
    spectral = SpectralClustering(n_clusters=2,
                                  eigen_solver="arpack",
                                  affinity="nearest_neighbors")
    dbscan = DBSCAN(eps=.2)
    affinity_propagation = AffinityPropagation(damping=.9, preference=-200)

    average_linkage = AgglomerativeClustering(
        linkage="average", affinity="cityblock", n_clusters=2,
        connectivity=connectivity)

    birch = Birch(n_clusters=2)
    clustering_algorithms = [
        two_means, affinity_propagation, ms, spectral, ward, average_linkage,
        dbscan, birch]

    for (name, algorithm) in zip(clustering_names, clustering_algorithms)
        fit!(algorithm, X)
        y_pred = nothing
        try
            y_pred = predict(algorithm, X)
        catch e
            if isa(e, KeyError)
                y_pred = map(Int, algorithm[:labels_])
                clamp!(y_pred, 0, 27) # not sure why some algorithms return -1
            else rethrow() end
        end
        subplot(4, length(clustering_algorithms), plot_num)
        if i_dataset == 1
            title(name, size=18)
        end

        for y_val in unique(y_pred)
            selected = y_pred.==y_val
            scatter(X[selected, 1], X[selected, 2], color=string(colors0[y_val+1]), s=10)
        end

        xlim(-2, 2)
        ylim(-2, 2)
        xticks(())
        yticks(())
        plot_num += 1
    end
end


