-- Utilities for dumping the information in DCS lua tables

---Somewhat neatly prints the input table to the DCS log.  Will crawl it recursively using dump_table_recursive()
---@param input table
function dump_table(input)
  for k, v in pairs(input) do
    vtype = type(v)
    if vtype == "table" then
      FCCLOG.info(k .. ": " .. dump_table_recursive(v))
    elseif vtype == "userdata" or vtype == "function" then
      FCCLOG.info(k .. ": " .. vtype)
    else
      FCCLOG.info(k .. ": " .. v)
    end
  end
end

---Crawls through table structures, returning the result as a formatted string
---@param input table
---@return string
function dump_table_recursive(input)
  local output = "{"
  for k, v in pairs(input) do
    output = output .. k .. ":"
    vtype = type(v)
    if vtype == "table" then
      output = output .. dump_table_recursive(v) .. ", "
    elseif vtype == "userdata" or vtype == "function" then
      FCCLOG.info(k .. ": " .. vtype)
    else
      output = output .. v
    end
  end
  output = output .. "}"
  return output
end