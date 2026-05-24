package main

import (
	"log"
	"net/http"
)

func indexPage(w http.ResponseWriter, r *http.Request) {
	http.ServeFile(w, r, "pages/index.html")
}

func aboutPage(w http.ResponseWriter, r *http.Request) {
	http.ServeFile(w, r, "pages/about.html")
}

func coursesPage(w http.ResponseWriter, r *http.Request) {
	http.ServeFile(w, r, "pages/courses.html")
}

func contactPage(w http.ResponseWriter, r *http.Request) {
	http.ServeFile(w, r, "pages/contact.html")
}

func main() {
	http.HandleFunc("/home", indexPage)
	http.HandleFunc("/about", aboutPage)
	http.HandleFunc("/courses", coursesPage)
	http.HandleFunc("/contact", contactPage)

	err := http.ListenAndServe("0.0.0.0:8080", nil)
	if err != nil {
		log.Fatal(err)
	}
}
