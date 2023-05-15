// swift-tools-version:5.7
import PackageDescription

let package = Package(
	name: "Telemetric",
	platforms: [
		.iOS(.v16)
	],
	products: [
		.library(
			name: "Telemetric",
			targets: ["Telemetric"]
		)
	],
	dependencies: [
		.package(url: "https://github.com/Fleuronic/Metric.git", branch: "main"),
		.package(url: "https://github.com/ReactiveCocoa/ReactiveCocoa", from: "12.0.0"),
		.package(url: "https://github.com/DeclarativeHub/Layoutless", .upToNextMajor(from: "0.4.0"))
	],
	targets: [
		.target(
			name: "Telemetric",
			dependencies: [
				"Metric",
				"ReactiveCocoa",
				"Layoutless"
			]
		),
		.testTarget(
			name: "TelemetricTests",
			dependencies: ["Telemetric"]
		)
	]
)
