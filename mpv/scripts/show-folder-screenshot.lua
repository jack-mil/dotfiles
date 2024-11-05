-- My (jack-mil) custom screenshot organization solution

-- Detects if current media title is an episode of a show,
-- and modfies the screenshot save template to save in a folder
-- for each show, and extract info about the episode for filename
-- Finely tuned for the media title set by the Jellyfin MPV Shim program

local utils = require('mp.utils')
local template = mp.get_property('screenshot-template')

-- string v is empty
local function empty(v)
  return not v or v == '' or v:find('^%s*$')
end

local function is_valid_title(s)
  -- ensures we only change the screenshot template when using jellyfin title format
  -- empty (nil) is invalid
  if empty(s) then return false end
  -- validate with pattern
  return s:match('^.+%s[Ss]%d+[Ee]%d+%s.*$') -- must contain SxxExx
end

-- Extract info about the show and episode and set the screenshot save path and name
local function folder_screenshot(name, media_title)
  -- print current title to console
  mp.msg.info('media_title(' .. utils.to_string(media_title) .. ')')

  -- don't modify save path if not using special jellyfin title
  if not is_valid_title(media_title) then return end

  -- assume format NAME - SxxExx - EPISODE TITLE
  _, _, show, ep, title = media_title:find('^(.-)%s%-%s(%w+)%s%-%s(.+)$')
  folder = string.gsub(show, '%p', '') -- strip any punctuation
  name = string.gsub(folder, '%s', '_') -- replace spaces with '_' in filename
  template = folder .. '/' .. name .. '-' .. ep .. '-%P' -- save file only contains show name and episode number

  mp.msg.info('screenshot-template(' .. template .. ')') -- print the new save path
  mp.set_property('screenshot-template', template)

  -- haven't gotten this to work with the crop script
  cropped_template = '~/Pictures/MPV/'
    .. folder
    .. '/'
    .. name
    .. '-'
    .. ep
    .. '-${#pos:%02h_%02m_%02.0s.%03M}${!full:-${crop_w}x${crop_h}-${%unique:%03d}}.${ext}'
  -- mp.msg.info('crop-template(' .. cropped_template .. ')')
  -- mp.commandv('raw', 'script-message', 'set-cropped-ss-dir', cropped_template)
end

-- run the function whenever the media-title changes
mp.observe_property('media-title', 'string', folder_screenshot)
