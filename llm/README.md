[] Steps for nvim
  [] ollama
    [] docker-compose from https://github.com/s1n7ax/home-server-ollama/
      [] https://github.com/s1n7ax/home-server-ollama/blob/main/docker-compose.yml
        [] NEEDED to add 'network_mode: "host" ' in all services
      [] docker compose up -d # Will donwload open-webui (LSP frontend and ollama)
      [] Ollama webpag
        [] http://localhost:8080
          [] Create account -some fake values- (mail: mail@box.com)
            [] rampxxxx/password #admin account (Must be created)
          [] Download model (as ollama don't have any)
            [] Go to "models" in the webpage http://ollama.com/library
              [] From https://www.youtube.com/watch?v=jy5gfjmXQG4 uses deepseek-code but as
                I've not nvidia will use deepseek-coder-v2 as it's said to be faster (but 16b as 236 is huge)
                [] Select and copy the download comman "ollama run deepseek-coder-v2:16b"
                [] Log into ollama (from docker-compose created server)
                  [] docker exec -it ollama bash
                    [] ollama pull deepseek-coder-v2:16b # To Download inside container.
          
  [] nvim plugin
