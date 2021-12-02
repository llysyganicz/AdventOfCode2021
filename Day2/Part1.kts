import java.io.File;
import java.io.InputStream;

fun getDistance(command: String): Int {
  return command.split(' ')[1].toInt()
}

val inputStream: InputStream = File("input.txt").inputStream()
val commands = mutableListOf<String>()

inputStream.bufferedReader().useLines { lines -> lines.forEach { commands.add(it) } }

val forward = commands.filter { command -> command.startsWith("forward") }
              .sumOf { getDistance(it) }

val down = commands.filter { command -> command.startsWith("down") }
              .sumOf { getDistance(it) }

val up = commands.filter { command -> command.startsWith("up") }
              .sumOf { getDistance(it) }

val result = forward * (down - up)

println(result)
