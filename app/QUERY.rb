QUERY="query { 
	search(query: "stars:>100", type: REPOSITORY, first: 100) {
    	nodes {
   		   ... on Repository {
      			  nameWithOwner
      			  url
    			  createdAt
        		  updatedAt
        		  pullRequests(states: MERGED) {
          			totalCount
        		   }
       			  releases {
         			totalCount
       			   }
       			   primaryLanguage{
          			name
       			   }
       			   numeroTotalIssues: issues {
       			        totalCount
       			   }
        		   numeroTotalIssuesClosed: issues(states: CLOSED) {
         			totalCount
       			   }
      		    }
   		}
  	}
	
      }"
