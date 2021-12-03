import java.io.File
import java.io.InputStream

val inputStream = File("input.txt").inputStream()
val binaries = mutableListOf<String>()

inputStream.bufferedReader().useLines { lines -> lines.forEach { binaries.add(it) } }
var gamma = ""
var epsilon = ""

for (i in 0..(binaries[0].count() - 1)) {
    val zerosCount = binaries.map { it[i] }.count { it == '0' }
    val onesCount = binaries.map { it[i] }.count { it == '1' }

    if (zerosCount > onesCount) {
        gamma += "0"
        epsilon += "1"
    }
    else {
        gamma += "1"
        epsilon += "0"
    }
}

val result = Integer.parseInt(gamma , 2) * Integer.parseInt(epsilon, 2)
println(result)