
QUERY= "query{
        search(query:\"stars:>100\", type:REPOSITORY, first:20){
    				pageInfo{
                hasNextPage
                endCursor
            }
   				 nodes{
                ... on Repository{
                    nameWithOwner
                    url
                    createdAt
                    pullRequests(states:MERGED){
                        totalCount
                    }
                    updatedAt
                    releases {
                        totalCount
                    }
                    opened_issues: issues{
                        totalCount
                    }
                    closed_issues: issues(states:CLOSED){
                       totalCount
                   }
                }
            }

        }


      }    "

