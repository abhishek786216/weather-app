// ✅ Apply necessary plugins
plugins {
    // Apply the Google Services plugin (for Firebase, if needed)
    id("com.google.gms.google-services") version "4.4.3" apply false
}

// ✅ Set up repositories for all projects
allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// ✅ Define a custom build directory
val newBuildDir = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.set(newBuildDir)

// ✅ Set custom build directories for each subproject
subprojects {
    val subBuildDir = newBuildDir.dir(project.name)
    project.layout.buildDirectory.set(subBuildDir)
}

// ✅ Ensure `:app` is evaluated first
subprojects {
    project.evaluationDependsOn(":app")
}

// ✅ Register a clean task to delete the custom build directory
tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
