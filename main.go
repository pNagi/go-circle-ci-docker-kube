package main

import (
  "fmt"
  "strconv"
  "net/http"
  "strings"
  "log"
  "github.com/pNagi/go-circleci-docker-kube/math/sqrt"
  "github.com/pNagi/go-circleci-docker-kube/math/add"
  "github.com/go-redis/redis"
)

func sayhelloName(w http.ResponseWriter, r *http.Request) {
  r.ParseForm()  // parse arguments, you have to call this by yourself
  // fmt.Println(r.Form)  // print form information in server side
  // fmt.Println("path", r.URL.Path)
  // fmt.Println("scheme", r.URL.Scheme)
  // fmt.Println(r.Form["url_long"])
  client := redis.NewClient(&redis.Options{
		Addr:     "localhost:6379",
		Password: "", // no password set
		DB:       0,  // use default DB
	})
  val, err := client.Get("_number").Result()
  fmt.Println("[err]", err, "[val]", val)
  if err == nil {
    i, _ := strconv.ParseInt(val, 0, 64)
    client.Set("_number", i + 1, 0).Err()
  } else {
    val = "redis_error"
    client.Set("_number", "0", 0).Err()
  }
  for k, v := range r.Form {
    fmt.Println("key:", k)
    fmt.Println("val:", strings.Join(v, ""))
  }
  sqrtResult := sqrt.Sqrt(4)
  addResult := add.Add(4, 4)
  fmt.Fprintf(w, "Hello, World! (%v, %v, %v)", sqrtResult, addResult, val) // send data to client side
}

func main() {
  http.HandleFunc("/", sayhelloName) // set router

  fmt.Println()
  fmt.Println("Server listening at 9090")
  fmt.Println()

  err := http.ListenAndServe(":9090", nil) // set listen port
  if err != nil {
    log.Fatal("ListenAndServe: ", err)
  }
}
