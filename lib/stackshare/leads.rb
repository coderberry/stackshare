module Stackshare
  class Leads
    LeadsQuery = Client.parse <<-'GRAPHQL'
      query($slugs: [String], $after: String) {
        leads(usingToolSlugs: $slugs, toolMatch: "any", after: $after){
          count
          pageInfo {
            startCursor
            hasNextPage
            endCursor
            hasPreviousPage
          }
          edges{
            node{
              companyId
              companyName
              domain
              companyTools {
                edges {
                  node {              
                    tool{
                      name
                      slug
                    }
                    sources
                    sourcesSummary
                  }
                }
              }
            }
          }
        }
      }
    GRAPHQL

    def self.leads(slugs, after)
      response = Stackshare::Leads.query(LeadsQuery, variables: { slugs: slugs, after: after })
      if response.errors.any?
        raise QueryExecutionError.new(response.errors[:data].join(", "))
      else
        response.data.leads
      end
    end
  end
end