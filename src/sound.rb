require 'dxruby'
require_relative './config'

$ruby_sound    = Sound.new("#{$ROOT_PATH}/sound/ruby.wav")
$castle_sound  = Sound.new("#{$ROOT_PATH}/sound/castle.wav")
$python_sound  = Sound.new("#{$ROOT_PATH}/sound/python.wav")
$bomb_sound    = Sound.new("#{$ROOT_PATH}/sound/bomb.wav")
$cookie_sound  = Sound.new("#{$ROOT_PATH}/sound/cookie.wav")