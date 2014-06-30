Typefactory.setup do |config|
  config.quotes_marks = [
    { :left => "&laquo;", :right => "&raquo;" },
    { :left => "&bdquo;", :right => "&ldquo;" },
    { :left => "&lsquo;", :right => "&rsquo;" }
  ]
  config.non_breaking_space = "&nbsp;"
end