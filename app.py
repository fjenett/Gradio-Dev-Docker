import gradio as gr

app = gr.Interface(
    title='Hello World ...',
    fn=lambda x: f'Hello {x}',
    inputs=gr.Textbox(),
    outputs=gr.Textbox()
)

app.launch(
    show_error=True, debug=True,
    server_name='0.0.0.0',
    # server_port=7860,
)