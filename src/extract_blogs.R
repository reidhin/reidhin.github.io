# create blogs-page
xml <- xml2::read_xml(url("https://medium.com/feed/@hans-10364"))

out = c()
out = c(out, paste0("<a href='", xml2::xml_text(xml2::xml_find_first(xml, ".//link")), "' style='color:inherit; text-decoration:none;'>"))
out = c(out, paste0("<h1>Blogs - ", xml2::xml_text(xml2::xml_find_first(xml, ".//title")), "</h1>"))
out = c(out, "</a>")
out = c(out, "<div id='myDIV' class='header'></div>")
for (item in xml2::xml_find_all(xml, ".//item")) {
  out = c(out, "<hr>")
  out = c(out, paste0("<a href='", xml2::xml_text(xml2::xml_find_first(item, ".//guid")), "' style='color:inherit; text-decoration:none;'>"))
  out = c(out, "<div class='row'>")
  out = c(out, "  <div class='col-sm-8'>")
  out = c(out, paste0("    <h4>", xml2::xml_text(xml2::xml_find_first(item, ".//title")), "</h4>"))
  out = c(out, paste0("    <h6>", xml2::xml_text(xml2::xml_find_first(item, ".//dc:creator")), " - ", xml2::xml_text(xml2::xml_find_first(item, ".//pubDate")), "</h6>"))
  out = c(out, "  </div>")
  out = c(out, "  <div class='col-sm-4'>")
  item_html <- xml2::read_html(xml2::xml_text(xml2::xml_find_first(item, ".//content:encoded")))
  out = c(out, paste0("    <img src='", xml2::xml_attr(xml2::xml_find_first(item_html, ".//img"), "src"), "' width='100%' alt='", xml2::xml_text(xml2::xml_find_first(item, ".//title")), "'>"))
  out = c(out, "  </div>")
  out = c(out, "</div>")
  out = c(out, "</a>")
}

fileConn<-file("parts/blogs.html")
writeLines(out, fileConn)
close(fileConn)
