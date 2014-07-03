// Comment to get more information during initialization
logLevel := Level.Warn

resolvers += "Typesafe repository" at "http://repo.typesafe.com/typesafe/releases/"

addSbtPlugin("com.typesafe.play" % "sbt-plugin" % "2.3.1")

libraryDependencies ++= Seq(
  "postgresql" % "postgresql" % "9.2-1002.jdbc4"
)