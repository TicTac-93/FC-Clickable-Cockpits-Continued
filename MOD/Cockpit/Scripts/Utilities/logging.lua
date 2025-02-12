local mod_log = "FC-Clickable"

FCCLOG = {
  info = function(msg)
    log.write(mod_log, log.INFO, msg)
  end,
  
  warning = function(msg)
    log.write(mod_log, log.WARNING, msg)
  end,
  
  error = function(msg)
    log.write(mod_log, log.ERROR, msg)
  end,
}