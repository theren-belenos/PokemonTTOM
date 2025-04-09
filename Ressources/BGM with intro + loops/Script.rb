module MusicLoops
  # Music looping: if a BGM file is listed here, the respective start and end
  # time will be used to loop the BGM after playing until the end once
  BGM = {
    "battle_rival" => [53.2, 108.04] # start, end (in seconds)
  }
end

class Game_System
  attr_accessor :bgm_loop_start
  attr_accessor :bgm_loops

  def bgm_play(bgm, track = nil)
    old_pos = @bgm_position
    @bgm_position = 0
    bgm_play_internal(bgm, 0, track)
    @bgm_position = old_pos
    if MusicLoops::BGM.has_key?(bgm.name)
      @bgm_loops = 0
      @bgm_loop_start = System.uptime
    end
  end

  def bgm_loop
    bgm = playing_bgm.name
    pbBGMFade(0.1)
    bgm_play_internal2("Audio/BGM/" + bgm, 100, 100, MusicLoops::BGM[bgm][0])
    @bgm_loop_start = System.uptime
    @bgm_loops += 1
  end

  alias bgmloop_update update unless method_defined?(:bgmloop_update)
  def update
    bgmloop_update
    return if !playing_bgm
    bgm = playing_bgm.name
    return if !MusicLoops::BGM.has_key?(bgm) || !@bgm_loop_start || @bgm_loop_start == 0
    # After intro is finished, jump back to loop start
    if System.uptime >= @bgm_loop_start + MusicLoops::BGM[bgm][1] && @bgm_loops == 0
      bgm_loop
      # After first loop, calculate timing based on loop duration (without intro)
    elsif System.uptime >= @bgm_loop_start + (MusicLoops::BGM[bgm][1] - MusicLoops::BGM[bgm][0]) && @bgm_loops > 0
      bgm_loop
    end
  end
end