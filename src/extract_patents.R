
# extract patents and save in file
url = "https://worldwide.espacenet.com/searchResults?compact=true&page=0&ST=advanced&AB=&PR=&IN=weda&rnd=1717927084587&locale=en_EP&AP=&PA=philips+OR+orikami&PD=&TI=&CPC=&Submit=Search&IC=&DB=EPODOC&PN="

df <- read.csv(file.path("inst", "extdata", "results_patents.csv"))
df <- read.csv2(file.path("inst", "extdata", "Espacenet_search_result_20240609_1148.csv"), skip=7, header=F)
colnames(df) <- df[1,]
df <- df[-1,]

out = c()

out = c(out, paste0("<a href='https://worldwide.espacenet.com/patent/search?q=in%20%3D%20%22weda%22%20AND%20%28pa%20%3D%20%22philips%22%20OR%20pa%20%3D%20%22orikami%22%29' style='color:inherit; text-decoration:none;'>"))
out = c(out, paste0("<h1>My Patents</h1>"))
out = c(out, "</a>")
out = c(out, "<hr>")
out = c(out, "<div id='myDIV' class='header'></div>")

out = c(out, "<table class='table table-hover'>")
out = c(out, "  <thead>")
out = c(out, "  <tr>")
out = c(out, "  <th scope='col'>No</th>")
out = c(out, "  <th scope='col'>Title</th>")
out = c(out, "  <th scope='col'>Publication number</th>")
out = c(out, "  <th scope='col'>Publication date</th>")
out = c(out, "  </tr>")
out = c(out, "  </thead>")
out = c(out, "  <tbody>")

for (i in 1:nrow(df)) {
  out = c(out, paste0("  <tr onclick=\"window.location='https://worldwide.espacenet.com/patent/search?q=pn%3D", sub("\n", "%20", df[i, "Publication number"]), "'\">"))
  out = c(out, paste0("  <th scope='row'>", i, "</th>"))
  out = c(out, paste0("  <td>", df[i, "Title"], "</td>"))
  out = c(out, paste0("  <td>", df[i, "Publication number"], "</td>"))
  out = c(out, paste0("  <td>", df[i, "Publication date"], "</td>"))
  out = c(out, "  </tr>")
}

out = c(out, "  </tbody>")
out = c(out, "</table>")

fileConn<-file("parts/patents.html")
writeLines(out, fileConn)
close(fileConn)