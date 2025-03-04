# enumSorter
# Kind of hacked together, this is made to sort DCS enums dumped via this method:
# https://forum.dcs.world/topic/57769-need-a-full-command-macro-list-for-losetcommand/#findComment-2309928

import os
enums = {}
with open(os.path.expandvars(R"%UserProfile%\Desktop\enumList.txt"), "r", encoding="UTF-8") as f:
  lines = f.readlines()
  for line in lines:
    line = line.split()
    # print(line)
    enums[line[1]] = line[0]

# Validate enums
blacklist = []
for key in enums.keys():
  try:
    x = int(key)
  except ValueError:
    blacklist.append(key)
    print("Skipping entry: {} {}".format(enums[key], key))
    continue

last_value = 0
best_match = 99999
exhausted = False
sorted = []
while not exhausted:
  best_match = 99999
  exhausted = True
  for key in enums.keys():
    if key in blacklist:
      continue

    key = int(key)
    if key == last_value + 1:
      best_match = key
      exhausted = False
      break
    elif key > last_value and key < best_match:
      best_match = key
      exhausted = False
  
  if not exhausted:
    # print("{}: {}".format(enums[str(best_match)], best_match))
    sorted.append("{}: {}\n".format(enums[str(best_match)], best_match))
    last_value = best_match

with open(os.path.expandvars(R"%UserProfile%\Desktop\enumSorted.txt"), "w+", encoding="UTF-8") as f:
  f.writelines(sorted)
