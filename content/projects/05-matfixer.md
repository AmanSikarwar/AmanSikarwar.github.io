---
title: MatFixer
tagline: Multi-agent AI that repairs MATLAB code
featured: false
accent: "#F472B6"
platforms: [Web]
tech: [Python, FastAPI, LangGraph, ChromaDB, pgvector, Flutter]
links:
  github: https://github.com/AmanSikarwar/matfixer
---

Multi-agent AI system that diagnoses and fixes MATLAB code: a LangGraph
workflow runs parallel RAG agents over ChromaDB knowledge bases (MATLAB docs,
Stack Overflow) alongside Tavily web search, then a Groq/Llama 3 synthesizer
merges everything into a root-cause report — plus a citation-grounded Gemini
RAG backend and a Flutter chat frontend with Firebase-stored feedback.
