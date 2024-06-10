# extract publications and save in file
url = "pub.orcid.org/v3.0/0000-0001-6675-2270/works"

response <- httr2::request(url) |> httr2::req_headers(Accept = "application/json") |> httr2::req_perform()
json <- response |> httr2::resp_body_json()

link_icon <- '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-link-45deg" viewBox="0 0 16 16">
  <path d="M4.715 6.542 3.343 7.914a3 3 0 1 0 4.243 4.243l1.828-1.829A3 3 0 0 0 8.586 5.5L8 6.086a1 1 0 0 0-.154.199 2 2 0 0 1 .861 3.337L6.88 11.45a2 2 0 1 1-2.83-2.83l.793-.792a4 4 0 0 1-.128-1.287z"/>
  <path d="M6.586 4.672A3 3 0 0 0 7.414 9.5l.775-.776a2 2 0 0 1-.896-3.346L9.12 3.55a2 2 0 1 1 2.83 2.83l-.793.792c.112.42.155.855.128 1.287l1.372-1.372a3 3 0 1 0-4.243-4.243z"/>
  </svg>'

process_json <- function() {
  out = c()
  
  out = c(out, paste0("<a href='https://orcid.org/0000-0001-6675-2270' style='color:inherit; text-decoration:none;'>"))
  out = c(out, paste0("<h1>My Publications</h1>"))
  out = c(out, "</a>")
  out = c(out, "<hr>")
  out = c(out, "<div id='myDIV' class='header'></div>")
  
  out = c(out, "<table class='table table-hover'>")
  out = c(out, "  <thead>")
  out = c(out, "  <tr>")
  out = c(out, "  <th scope='col'>No</th>")
  out = c(out, "  <th scope='col'>Title</th>")
  out = c(out, "  <th scope='col'>DOI</th>")
  out = c(out, "  </tr>")
  out = c(out, "  </thead>")
  out = c(out, "  <tbody>")
  
  for (i in 1:length(json$group)) {
    doi <- json$group[[i]]$`external-ids`$`external-id`[[1]]$`external-id-value`
    ref <- paste0("https://doi.org/", doi)
    out = c(out, paste0("  <tr onclick=\"window.location='", ref, "'\">"))
    out = c(out, paste0("  <th scope='row'>", i, "</th>"))
    out = c(out, paste0(
      "  <td>", 
      gsub("<.*?>", "", json$group[[i]]$`work-summary`[[1]]$title$title$value), 
      "<br>",
      "<small class='text-secondary'>", 
      stringr::str_c(
        json$group[[i]]$`work-summary`[[1]]$`journal-title`$value,
        stringr::str_c(
          json$group[[i]]$`work-summary`[[1]]$`publication-date`$day$value,
          json$group[[i]]$`work-summary`[[1]]$`publication-date`$month$value,
          json$group[[i]]$`work-summary`[[1]]$`publication-date`$year$value,
          sep = "-"
        ),
        json$group[[i]]$`work-summary`[[1]]$type,
        sep = " | "
      ),
      "</small>",
      "</td>"
    ))
    out = c(out, paste0("  <td>", doi, '</td>'))
    out = c(out, "  </tr>")
  }
  
  out = c(out, "  </tbody>")
  out = c(out, "</table>")
  
  return(out)
}

out <- process_json()
fileConn<-file("parts/publications.html")
writeLines(out, fileConn)
close(fileConn)
