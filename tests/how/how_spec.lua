local plugin = require("how")

describe("setup", function()
  it("works with default", function()
    assert(plugin.hello() == "Hello!", "my first function with param = Hello!")
  end)

  it("works with custom var", function()
    plugin.setup({ opt = "custom" })
    assert(plugin.hello() == "custom", "my first function with param = custom")
  end)
end)


describe("database", function()
    it("can find sqlite package", function()
    assert(plugin.db, "Checks for plugin.db being defined")
    end)
end)
