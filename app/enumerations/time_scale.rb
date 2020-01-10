class TimeScale < EnumerateIt::Base
  associate_values(
    :seconds,
    :minutes
  )
end
