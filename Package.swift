// swift-tools-version:5.5
import PackageDescription

let package = Package(
	name: "Telemetric",
	platforms: [
		.iOS(.v15)
	],
	products: [
		.library(
			name: "Telemetric",
			targets: [
				"Telemetric"
			]
		)
	],
	dependencies: [
		.package(url: "https://github.com/Fleuronic/Metric.git", .branch("main")),
		.package(url: "https://github.com/DeclarativeHub/Bond", .upToNextMajor(from: "7.0.0")),
		.package(url: "https://github.com/yannickl/DynamicColor", from: "5.0.1")
	],
	targets: [
		.target(
			name: "Telemetric",
			dependencies: [
				"Metric",
				"Bond",
				"DynamicColor"
			]
		),
		.testTarget(
			name: "TelemetricTests",
			dependencies: ["Telemetric"]
		)
	]
)
