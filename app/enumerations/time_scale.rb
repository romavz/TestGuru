class TimeScale < EnumerateIt::Base
  associate_values(
    :seconds,
    :minutes,
    :hours,
    :days
  )
end
