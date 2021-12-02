import java.io.File;
import java.io.InputStream;

fun parseLine(line: String): Pair<String, Int> {
  val splittedLine = line.split(' ')
  return (splittedLine[0] to splittedLine[1].toInt())
}

fun processLines(lines: Sequence<String>): Int {
  var forward = 0
  var aim = 0
  var depth = 0
  lines.forEach {
    val (direction, units) = parseLine(it)
    when (direction) {
      "forward" -> { 
        forward += units
        depth += aim * units
      }
      "down" -> aim += units
      "up" -> aim -= units
    }
  }
  return forward * depth
}

val inputStream: InputStream = File("input.txt").inputStream()

val result = inputStream.bufferedReader().useLines { processLines(it) }

println(result)
