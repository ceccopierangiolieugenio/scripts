package main

import (
	"log"
	"encoding/json"
)

type A struct{
  A string `json:"a"`
  C int    `json:"c"`
}

type B struct{
  A string `json:"a"`
  D int    `json:"d"`
}

type C struct{
  A string `json:"a"`
  C int    `json:"c"`
  D int    `json:"d"`
}

type Bird struct {
  Species string `json:"birdType"`
  Description string `json:"what it does"`
}

func main() {
	var message map[string]interface{}
        byt := []byte(`{"a":"Eugenio","c":12345}`)
	json.Unmarshal(byt, &message)

	var aa A
	var bb B
	var cc C

	log.Printf("A", json.Unmarshal(byt, &aa))
	log.Printf("B", json.Unmarshal(byt, &bb))
	log.Printf("C", json.Unmarshal(byt, &cc))

	log.Printf("aa", aa)
	log.Printf("bb", bb)
	log.Printf("cc", cc)

	log.Printf("message", message)

	eventType := message["a"]
	log.Printf("et",eventType)

	b := message["b"]
	log.Printf("b",b)

	c := message["c"]
	log.Printf("c",c)

	birdJson := `{"birdType": "pigeon","what it does": "likes to perch on rocks"}`
	var bird Bird
	json.Unmarshal([]byte(birdJson), &bird)
	log.Println(bird)
	// {pigeon likes to perch on rocks}
}

