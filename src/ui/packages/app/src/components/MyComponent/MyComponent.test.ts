import { test, describe, assert, afterEach } from "vitest";
import { cleanup, render } from "@gradio/tootils";

import MyComponent from "./MyComponent.svelte";
import type { LoadingStatus } from "../StatusTracker/types";

const loading_status = {
	eta: 0,
	queue_position: 1,
	queue_size: 1,
	status: "complete" as LoadingStatus["status"],
	scroll_to_output: false,
	visible: true,
	fn_index: 0
};

describe("MyComponent", () => {
	afterEach(() => cleanup());

	test("renders provided value", () => {
		const { getByDisplayValue } = render(MyComponent, {
			loading_status,
			show_label: true,
			mode: "dynamic",
			value: "#000000",
			label: "MyComponent"
		});

		const item: HTMLInputElement = getByDisplayValue("#000000");
		assert.equal(item.value, "#000000");
	});

	test("changing the color should update the value", async () => {
		const { component, getByDisplayValue } = render(MyComponent, {
			loading_status,
			show_label: true,
			mode: "dynamic",
			value: "#000000",
			label: "MyComponent"
		});

		const item: HTMLInputElement = getByDisplayValue("#000000");

		assert.equal(item.value, "#000000");

		await component.$set({
			value: "#FFFFFF"
		});

		assert.equal(component.value, "#FFFFFF");
	});
});