# task4.rb

require "win32/sound"
include Win32

class Sound
  def initialize(noteName)
    @noteName = noteName
  end

  # def sound
  #   Sound.beep(525, 1500)
  #   puts ""
  # end
end

class Csound < Sound
  def sound
    puts "this is 'c' sound"
    Sound.beep(525, 1500) #c
    # Sound.beep(1050, 1500) #c
  end
end

class Dsound < Sound
  def sound
    puts "this is 'd' sound"
    Sound.beep(600, 1500) #d
  end
end

class Esound < Sound
  def sound
    puts "this is 'e' sound"
    Sound.beep(660, 1500) #e
  end
end

class Fsound < Sound
  def sound
    puts "this is 'f' sound"
    Sound.beep(700, 1500) #f
  end
end

class Gsound < Sound
  def sound
    puts "this is 'g' sound"
    Sound.beep(780, 1500) #g
  end
end

class Asound < Sound
  def sound
    puts "this is 'a' sound"
    Sound.beep(880, 1500) #a
  end
end

class Bsound < Sound
  def sound
    puts "this is 'b' sound"
    Sound.beep(990, 1500) #b
  end
end

print "enter the note name(c to b): "
noteName = gets.chomp

if noteName == "c"
  sound = Csound.new(noteName)
  sound.sound
elsif noteName == "d"
  sound = Dsound.new(noteName)
  sound.sound
elsif noteName == "e"
  sound = Esound.new(noteName)
  sound.sound
elsif noteName == "f"
  sound = Fsound.new(noteName)
  sound.sound
elsif noteName == "g"
  sound = Gsound.new(noteName)
  sound.sound
elsif noteName == "a"
  sound = Asound.new(noteName)
  sound.sound
elsif noteName == "b"
  sound = Bsound.new(noteName)
  sound.sound
else
  puts "please enter the note name."
  Sound.play('chimes.wav')
end
