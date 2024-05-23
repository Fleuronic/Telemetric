// swift-tools-version:5.6
import PackageDescription

let package = Package(
	name: "Telemetric",
	platforms: [
		.iOS(.v15)
	],
	products: [
		.library(
			name: "Telemetric",
			targets: ["Telemetric"]
		)
	],
	dependencies: [
		.package(url: "https://github.com/Fleuronic/Metric", branch: "main"),
		.package(url: "https://github.com/Fleuronic/Geometric", branch: "main"),
		.package(url: "https://github.com/ReactiveCocoa/ReactiveCocoa", from: "12.0.0"),
		.package(url: "https://github.com/Fleuronic/ReactiveDataSources", branch: "master"),
	],
	targets: [
		.target(
			name: "Telemetric",
			dependencies: [
				"Metric",
				"Geometric",
				"ReactiveCocoa",
				"ReactiveDataSources"
			]
		),
		.testTarget(
			name: "TelemetricTests",
			dependencies: ["Telemetric"]
		)
	]
)
