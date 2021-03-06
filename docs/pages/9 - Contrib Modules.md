## Contrib Modules

### ScalaPB

This module allows [ScalaPB](https://scalapb.github.io) to be used in Mill builds. ScalaPB is a [Protocol Buffers](https://developers.google.com/protocol-buffers/) compiler plugin that generates Scala case classes, encoders and decoders for protobuf messages.

To declare a module that uses ScalaPB you can extend the `mill.contrib.scalapblib.ScalaPBModule` trait when defining your module.

This creates a Scala module which compiles `.proto` files in the `protobuf` folder of the module with ScalaPB and adds the resulting `.scala` sources to your module's `generatedSources`.

```scala
// build.sc
import mill._, scalalib._, contrib.scalapblib.__

object example extends ScalaPBModule {
  def scalaVersion = "2.12.6"
  def scalaPBVersion = "0.7.4"
}
```

This defines a project with the following layout:

```
build.sc
example/
    src/
    protobuf/
    resources/
```

#### Configuration options

* scalaPBVersion (mandatory) - The ScalaPB version `String` e.g. `"0.7.4"`

* scalaPBFlatPackage - A `Boolean` option which determines whether the `.proto` file name should be appended as the final segment of the package name in the generated sources.

* scalaPBJavaConversions - A `Boolean` option which determines whether methods for converting between the generated Scala classes and the Protocol Buffers Java API classes should be generated.

* scalaPBGrpc - A `Boolean` option which determines whether [grpc](https://grpc.io) stubs should be generated.

* scalaPBSingleLineToProtoString - A `Boolean` option which determines whether the generated `.toString` methods should use a single line format.

If you'd like to configure the options that are passed to the ScalaPB compiler directly, you can override the `scalaPBOptions` task, for example:

```scala
object example extends ScalaPBModule {
  def scalaVersion = "2.12.6"
  def scalaPBVersion = "0.7.4"
  override def scalaPBOptions = "flat_package,java_conversions"
}
```

### BuildInfo

Generate scala code from your buildfile.  
This plugin generates a single object containing information from your build.
  
To declare a module that uses BuildInfo you must extend the `mill.contrib.BuildInfo` trait when defining your module.

Quickstart:
  ```scala
  object project extends BuildInfo {
    val name = "poject-name"
    def  buildInfoMembers: T[Map[String, String]] = T {
      Map(
        "name" -> name),
        "scalaVersion" -> scalaVersion()
      )
    }
  }
  ```
  
#### Configuration options

* `def buildInfoMembers: T[Map[String, String]]`  
  The map containing all member names and values for the generated info object.

* `def buildInfoObjectName: String`, default: `BuildInfo`  
  The name of the object which contains all the members from `buildInfoMembers`.

* `def buildInfoPackageName: Option[String]`, default: `None`  
  The package name of the object.


### Other Mill Plugins

- [ensime](https://github.com/yyadavalli/mill-ensime "mill-ensime")

  Create an [.ensime](http://ensime.github.io/ "ensime") file for your build.
  
  Quickstart:
  ```scala
  import $ivy.`fun.valycorp::mill-ensime:0.0.1`
  ```
  ```sh
  sh> mill fun.valycorp.mill.GenEnsime/ensimeConfig
  ```
  
- [dgraph](https://github.com/ajrnz/mill-dgraph "mill-dgraph")

  Show transitive dependencies of your build in your browser.
  
  Quickstart:
  ```scala
  import $ivy.`com.github.ajrnz::mill-dgraph:0.2.0`
  ```
  ```sh
  sh> mill plugin.dgraph.browseDeps(proj)()
  ```
