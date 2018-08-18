
files <- list.files("img")

for (f in files) {
  print(f)
  file.rename(paste0("img/",f), paste0("img/class3_",paste0(substr(f,9,nchar(f)))))
}

file.rename()

