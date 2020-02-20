QUERY="query { 
	search(query:\"stars:>100\",type:REPOSITORY,first:10){
    	nodes{
        ... on Repository{
          nameWithOwner 
          url
          createdAt
        }
      }
  }
}"
