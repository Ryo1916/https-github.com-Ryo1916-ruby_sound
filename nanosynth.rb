# nanosynth.rb

gem 'wavefile', '=0.8.1'
require 'wavefile'

OUTPUT_FILENAME = "mysound.wav"
SAMPLE_RATE = 44100
# call const number 'pi' in class of Math
TWO_PI = 2 * Math::PI
RANDOM_GENERATOR = Random.new

def main(wave_type, frequency, max_amplitude)
  # Generate 1 second of sample data at the given frequency and amplitude.
  # Since we are using a sample rate of 44,100Hz,
  # 44,100 samples are required for one second of sound.
  samples = generate_sample_data(wave_type, 44100, frequency, max_amplitude)

  # Wrap the array of samples in a Buffer, so that it can be written to a Wave file
  # by the WaveFile gem. Since we generated samples between -1.0 and 1.0, the sample
  # type should be :float
  buffer = WaveFile::Buffer.new(samples, WaveFile::Format.new(:mono, :float, 44100))

  # Write the Buffer containing our samples to a 16-bit, monophonic Wave file
  # with a sample rate of 44,100Hz, using the WaveFile gem.
  WaveFile::Writer.new(OUTPUT_FILENAME, WaveFile::Format.new(:stereo, :pcm_16, 44100)) do |writer|
    writer.write(buffer)
  end

  
end

# The dark heart of NanoSynth, the part that actually generates the audio data
def generate_sample_data(wave_type, num_samples, frequency, max_amplitude)
  position_in_period = 0.0
  position_in_period_delta = frequency / SAMPLE_RATE

  # Initialize an array of samples set to 0.0. Each sample will be replaced with
  # an actual value below.
  # Make array, it has 0.0 44100 times
  samples = [].fill(0.0, 0, num_samples)

  num_samples.times do |i|
    # Add next sample to sample list. The sample value is determined by
    # plugging the period offset into the appropriate wave function.

    if wave_type == :sine
      samples[i] = Math::sin(position_in_period * TWO_PI) * max_amplitude
    elsif wave_type == :square
      samples[i] = (position_in_period >= 0.5) ? max_amplitude : -max_amplitude
    elsif wave_type == :saw
      samples[i] = ((position_in_period * 2.0) - 1.0) * max_amplitude
    elsif wave_type == :triangle
      samples[i] = max_amplitude - (((position_in_period * 2.0) - 1.0) * max_amplitude * 2.0).abs
    elsif wave_type == :noise
      samples[i] = RANDOM_GENERATOR.rand(-max_amplitude..max_amplitude)
    end

    position_in_period += position_in_period_delta

    # Constrain the period between 0.0 and 1.0
    if(position_in_period >= 1.0)
      position_in_period -= 1.0
    end
  end

  samples
  # return []
end

print "enter the wave type(sine, square, saw, triangle, noise): "
wave_type = gets.chomp        # Should be "sine", "square", "saw", "triangle", or "noise"
wave_type = wave_type.to_sym  # if "sine" is entered, it becomes ":sine"

if wave_type == :sine || wave_type == :square || wave_type == :saw || wave_type == :triangle || wave_type == :noise
  print "enter the frequency(20 to 20000): "
  frequency = gets.to_f   # 440.0 is the same as middle-A on a piano.
  if frequency >= 20 && frequency <= 20000
    print "enter the max amplitude(0.0 to 1.0): "
    max_amplitude = gets.to_f     # Should be between 0.0 (silence) and 1.0 (full volume).
                                  # Amplitudes above 1.0 will result in distortion
                                  # (or other weirdness).
    if max_amplitude >= 0.0 && max_amplitude <= 1.0
      main(wave_type, frequency, max_amplitude)
    else
      puts "please enter the correct max amplitude"
    end
  else
    puts "please enter the correct frequency"
  end
else
  puts "please enter the correct wave type"
end
