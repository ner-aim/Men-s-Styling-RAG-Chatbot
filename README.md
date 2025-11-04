# 👔 Men’s Styling RAG Chatbot  

> 🔗 **[Watch the demo video](YOUR_VIDEO_LINK_HERE)**  

This project builds a **Retrieval-Augmented Generation (RAG)** chatbot that answers questions about **men’s styling** using a collection of PDF guides (watches, grooming, fragrances, shoes, and more).  
It combines **Snowflake Cortex Search** for hybrid vector retrieval with **LLMs (Mistral-Large2, Llama3)** to deliver grounded, context-aware responses through a **Streamlit** chat interface.  

---

## 🧠 Overview  

The assistant answers fashion questions with grounded, factual responses by retrieving context from your private style library.  
Instead of guessing, the model references PDFs like *“Ultimate Guide to Men’s Watches”* or *“How to Dress Sharp Without Burning Up”* before generating advice.  

**Key features:**  
- Full **RAG pipeline** - document parsing, chunking, classification, retrieval, and LLM generation.  
- **Hybrid search** with Snowflake Cortex (semantic + keyword).  
- **Context toggle** in Streamlit to compare grounded vs non-grounded LLM answers.  
- Planned automation with **Streams + Tasks + Stored Procedures** for self-updating document ingestion.  

---

## ⚙️ Tech Stack  

| Layer | Tool | Purpose |
|-------|------|----------|
| Data Store | **Snowflake** | Host parsed and chunked documents |
| Vector Retrieval | **Snowflake Cortex Search** | Embeddings + hybrid similarity search |
| LLMs | **Mistral-Large2**, **Llama3**, **Snowflake-Arctic** | Context-aware generation |
| Interface | **Streamlit** | Chat UI with context toggle and category filters |
| Language | **Python 3.11**, **SQL** | Backend logic + RAG orchestration |

---

## 🧩 Repository Structure  

📁 men-style-rag-chatbot/
├── setup.sql # Create database, schema, and stage
├── parse_documents.sql # Parse PDFs and extract text
├── chunking_classify.sql # Chunk text and classify categories
├── search_service.sql # Create Cortex Search service
├── streamlit_app.py # Chat UI with retrieval + generation logic
└── README.md # Project documentation


## 💬 Streamlit Chat App

Allows switching between “with context” and “without context” responses.

Displays retrieved document chunks in a sidebar for transparency.

Supports category filters (Watches, Grooming, Fragrance, etc.).

Example question:

“What ring finger meanings should I know in the US?”
→ Returns a grounded response sourced from Ring-fingers-symbolism.pdf.

## 🔄 Future Work

Automate document ingestion using Streams and Tasks to parse and classify new PDFs.

Extend chat memory with conversation summarization for follow-up questions.

Integrate multi-modal retrieval for style image references.

## 🧠 Inspiration

_“RAG isn’t just for enterprise docs — it can power a personalized AI that knows your aesthetic, your wardrobe, your vibe.”_
