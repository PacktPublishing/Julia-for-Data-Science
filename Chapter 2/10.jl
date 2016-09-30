using JSON, Requests
reddit_url = "https://www.reddit.com/r/Julia/"
response = get("$(reddit_url)/.json")
dataReceived = JSON.parse(Requests.text(response))
nextRecord = dataReceived["data"]["after"]
counter = length(dataReceived["data"]["children"])

allPosts = []
for record in 1:counter
    url = dataReceived["data"]["children"][record]["data"]["url"]
    redditrecord_id  = dataReceived["data"]["children"][record]["data"]["id"]
    redditrecord_title  = dataReceived["data"]["children"][record]["data"]["title"]
    author  = dataReceived["data"]["children"][record]["data"]["author"]
    created = dataReceived["data"]["children"][record]["data"]["created"]
    push!(allPosts, (url, redditrecord_id, redditrecord_title, author, created))
end

for post in allPosts
    println(post[3])
end
