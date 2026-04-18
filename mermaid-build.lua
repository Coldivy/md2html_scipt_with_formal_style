function CodeBlock(el)
    if el.classes:includes("mermaid") then
        return pandoc.RawBlock("html", '<div class="mermaid">' .. el.text .. '</div>')
    end
end
