module.exports = (robot) ->
  github = "https://github.com/librenms/librenms"
  channel = "##librenms"
  nick = process.env.HUBOT_IRC_NICK
  robot.respond /team/i, (msg) ->
    msg.send "blahdeblah, laf, f0o, Rosiak, SaaldjorMike, murrant"
  robot.hear /create a feature request/i, (msg) ->
    msg.send "You can create a feature request on the community site: https://t.libren.ms/hyz37"
  robot.hear /creat(e|ing) an issue/i, (msg) ->
    msg.send "You can create an issue on github: #{github}/issues"
  robot.hear /(poller|discovery) (.*)([ ]*)debug/i, (msg) ->
    type = msg.match[1].toLowerCase()
    module = msg.match[2].toLowerCase()
    if type is "poller"
        poller_flags = "-r -f"
    else
        poller_flags = ""
    if module
      module = "-m #{module}"
    else
      module = ""
    msg.send "./#{type}.php #{poller_flags} #{module} -h HOSTNAME -d"
  robot.hear /(.*) validate your install/i, (msg) ->
    user = msg.match[1]
    msg.send "#{user} to validate your install run ./validate.php and then pastebin your results"
  robot.hear /(good|awesome|cool|sexy) bot/i, (msg) ->
    msg.reply "Aw, thanks :)"
  robot.hear /(bad|silly|stupid|lame|crap) bot/i, (msg) ->
    msg.reply "Why so mean :("
  robot.hear /(flip|flipping) tables/i, (msg) ->
    msg.send "AGHHHHHHHHHHH"
    msg.send "(╯°□°）╯︵ ┻━┻"
  robot.hear /(.*)allah is doing(.*)/i, (msg) ->
    user = msg.message.user.name
    robot.adapter.command "KICK", channel, user, nick, "Not here!"
