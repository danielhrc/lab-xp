QUERY= "query exercicio {
             search(query: \"stars:>100\", type: REPOSITORY, first: 100) {
                      nodes {
                             ... on Repository {
                                        nameWithOwner
                                        createdAt
                                        primaryLanguage { name }
                                        issuesTotal: issues { totalCount }
                                        issues(states:CLOSED){ totalCount }
                                      #  pullRequests(states: MERGED) { totalCount }
                                      }
                            }
                      }
              }"
