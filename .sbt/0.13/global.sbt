// WORKAROUND https://github.com/rtimush/sbt-updates/issues/10
addCommandAlias("pluginDependencyUpdates", "; reload plugins; dependencyUpdates; reload return")

net.virtualvoid.sbt.graph.Plugin.graphSettings

useGpg := true

gpgCommand := "/usr/bin/gpg2"
