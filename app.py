import gradio as gr

app = gr.Interface(
    title='Hello World ...',
    fn=lambda x, y: f'Hello {x} {y}',
    inputs=[
        gr.Textbox(),
        gr.MyComponent()
    ],
    outputs=gr.Textbox()
)

app.launch(
    show_error=True, debug=True,
    server_name='0.0.0.0',
    # server_port=7860,
)