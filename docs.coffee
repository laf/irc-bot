module.exports = (robot) ->
  service = "http://docs.librenms.org"
  robot.respond /docs search (.*)/i, (msg) ->
    needle = msg.match[1].toLowerCase()
    needles = "(.*"+needle.replace(/\ /g, ")(.*") + ")"
    needle_regex = new RegExp("#{needles}")
    msg.http('https://raw.githubusercontent.com/librenms-docs/librenms-docs.github.io/master/mkdocs/search_index.json')
      .header('Accept', 'application/json')
        .get() (err, res, body) ->
          try
            data = JSON.parse body
          catch
            console.log(err)
            msg.send "Eeek, something has gone wrong with the response, check your settings!"
          if data
            #
            urls = []
            i=0
            for k,v of data.docs
              text = v.text.toString().toLowerCase()
              if match = needle_regex.test(text)
                if not /\/General\/Changelog\//.test(v.location)
                  urls[v.title] = v.location
                  i++
                  if i > 2
                    break
            count = urls.length
            msg.send "Found #{i} docs"
            for k,v of urls
                msg.send "#{k} -> #{service}#{v}"
  robot.respond /docs([ ]*)(.*)/i, (msg) ->
    wanted     = msg.match[2].toLowerCase()
    docs = 
      api: "/API/API-Docs/"
      alerting: "/Extensions/Alerting/"
      distributed: "/Extensions/Distributed-Poller/"
      mibpolling: "/Extensions/MIB-based-polling/"
      influx: "/Extensions/InfluxDB/"
      influxdb: "/Extensions/InfluxDB/"
      oxidized: "/Extensions/Oxidized/"
      smokeping: "/Extensions/Smokeping/"
      services: "/Extensions/Services/"
      performance: "/Support/Performance/"
      faq: "/Support/FAQ/"
    if wanted and docs[wanted]
      selected = docs[wanted]
      msg.send "Are you looking for: #{service}#{selected}"
    else
      msg.send "#{service}"
