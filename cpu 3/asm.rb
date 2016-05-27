def store?(char)
  if char == "s"
    return 0
  elsif char == "S"
    return 1
  end
  throw("No valid character detected")
end
def jump?(char)
  if char == "j"
    return 0
  elsif char == "J"
    return 1
  end
  throw("No valid character detected")
end

Isel={"M"=>0,"I"=>1,"R"=>10}
Osel={"+"=>0,"-"=>1,"="=>10,"H"=>11}
puts "File:"
inFile = gets.chomp
unless inFile.include?(".asm")
  inFile+=".asm"
end

outFile = inFile.gsub(".asm",".code")
outFile = File.open(outFile,"w")
File.open(inFile,"r") do |f|
  outFile.puts "v2.0 raw"
  f.each_line do |line|
    line = line.split(" ")
    bina = Isel[line[0]].to_s.rjust(2, "0")
    binb = Isel[line[1]].to_s.rjust(2, "0")
    bino = Osel[line[2]].to_s.rjust(2, "0")
    store = store?(line[3]).to_s
    jump = jump?(line[4]).to_s
    addr = line[5]
    op = jump + store + bino + binb + bina
    op = op.to_i(2).to_s(16).rjust(2, "0")
    op += addr
    outFile.puts op
  end
end
outFile.close