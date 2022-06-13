local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
	return
end

require "user.lsp.null-ls"

require("nvim-lsp-installer").setup({
    automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})

local function setup()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end

  local config = {
    -- disable virtual text
    virtual_text = false,
    -- show signs
    signs = {
      active = signs,
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })
end
setup()

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

require('lspconfig')['clangd'].setup {
    capabilities = capabilities
}

-- Find more schemas here: https://www.schemastore.org/json/
local schemas = {
  {
    description = "TypeScript compiler configuration file",
    fileMatch = {
      "tsconfig.json",
      "tsconfig.*.json",
    },
    url = "https://json.schemastore.org/tsconfig.json",
  },
  {
    description = "Lerna config",
    fileMatch = { "lerna.json" },
    url = "https://json.schemastore.org/lerna.json",
  },
  {
    description = "Babel configuration",
    fileMatch = {
      ".babelrc.json",
      ".babelrc",
      "babel.config.json",
    },
    url = "https://json.schemastore.org/babelrc.json",
  },
  {
    description = "ESLint config",
    fileMatch = {
      ".eslintrc.json",
      ".eslintrc",
    },
    url = "https://json.schemastore.org/eslintrc.json",
  },
  {
    description = "Bucklescript config",
    fileMatch = { "bsconfig.json" },
    url = "https://raw.githubusercontent.com/rescript-lang/rescript-compiler/8.2.0/docs/docson/build-schema.json",
  },
  {
    description = "Prettier config",
    fileMatch = {
      ".prettierrc",
      ".prettierrc.json",
      "prettier.config.json",
    },
    url = "https://json.schemastore.org/prettierrc",
  },
  {
    description = "Vercel Now config",
    fileMatch = { "now.json" },
    url = "https://json.schemastore.org/now",
  },
  {
    description = "Stylelint config",
    fileMatch = {
      ".stylelintrc",
      ".stylelintrc.json",
      "stylelint.config.json",
    },
    url = "https://json.schemastore.org/stylelintrc",
  },
  {
    description = "A JSON schema for the ASP.NET LaunchSettings.json files",
    fileMatch = { "launchsettings.json" },
    url = "https://json.schemastore.org/launchsettings.json",
  },
  {
    description = "Schema for CMake Presets",
    fileMatch = {
      "CMakePresets.json",
      "CMakeUserPresets.json",
    },
    url = "https://raw.githubusercontent.com/Kitware/CMake/master/Help/manual/presets/schema.json",
  },
  {
    description = "Configuration file as an alternative for configuring your repository in the settings page.",
    fileMatch = {
      ".codeclimate.json",
    },
    url = "https://json.schemastore.org/codeclimate.json",
  },
  {
    description = "LLVM compilation database",
    fileMatch = {
      "compile_commands.json",
    },
    url = "https://json.schemastore.org/compile-commands.json",
  },
  {
    description = "Config file for Command Task Runner",
    fileMatch = {
      "commands.json",
    },
    url = "https://json.schemastore.org/commands.json",
  },
  {
    description = "AWS CloudFormation provides a common language for you to describe and provision all the infrastructure resources in your cloud environment.",
    fileMatch = {
      "*.cf.json",
      "cloudformation.json",
    },
    url = "https://raw.githubusercontent.com/awslabs/goformation/v5.2.9/schema/cloudformation.schema.json",
  },
  {
    description = "The AWS Serverless Application Model (AWS SAM, previously known as Project Flourish) extends AWS CloudFormation to provide a simplified way of defining the Amazon API Gateway APIs, AWS Lambda functions, and Amazon DynamoDB tables needed by your serverless application.",
    fileMatch = {
      "serverless.template",
      "*.sam.json",
      "sam.json",
    },
    url = "https://raw.githubusercontent.com/awslabs/goformation/v5.2.9/schema/sam.schema.json",
  },
  {
    description = "Json schema for properties json file for a GitHub Workflow template",
    fileMatch = {
      ".github/workflow-templates/**.properties.json",
    },
    url = "https://json.schemastore.org/github-workflow-template-properties.json",
  },
  {
    description = "golangci-lint configuration file",
    fileMatch = {
      ".golangci.toml",
      ".golangci.json",
    },
    url = "https://json.schemastore.org/golangci-lint.json",
  },
  {
    description = "JSON schema for the JSON Feed format",
    fileMatch = {
      "feed.json",
    },
    url = "https://json.schemastore.org/feed.json",
    versions = {
      ["1"] = "https://json.schemastore.org/feed-1.json",
      ["1.1"] = "https://json.schemastore.org/feed.json",
    },
  },
  {
    description = "Packer template JSON configuration",
    fileMatch = {
      "packer.json",
    },
    url = "https://json.schemastore.org/packer.json",
  },
  {
    description = "NPM configuration file",
    fileMatch = {
      "package.json",
    },
    url = "https://json.schemastore.org/package.json",
  },
  {
    description = "JSON schema for Visual Studio component configuration files",
    fileMatch = {
      "*.vsconfig",
    },
    url = "https://json.schemastore.org/vsconfig.json",
  },
  {
    description = "Resume json",
    fileMatch = { "resume.json" },
    url = "https://raw.githubusercontent.com/jsonresume/resume-schema/v1.0.0/schema.json",
  },
}
require('lspconfig')['jsonls'].setup {
    capabilities = capabilities,
    settings = {
        json = {
            schemas = schemas,
        },
    },
    setup = {
        commands = {
            Format = {
                function()
                    vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line "$", 0 })
                end,
            },
        },
    },
}

local pid = vim.fn.getpid()
require('lspconfig')['omnisharp'].setup {
    capabilities = capabilities,
    cmd = { 'OmniSharp', '--languageserver', '--hostPID', tostring(pid) }
}

require('lspconfig')['pyright'].setup {
    capabilities = capabilities,
    settings = {
        python = {
            analysis = {
                typeCheckingMode = "off"
            }
        }
    }
}

require('lspconfig')['rust_analyzer'].setup {
    capabilities = capabilities
}

require('lspconfig')['sumneko_lua'].setup {
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.stdpath("config") .. "/lua"] = true,
                },
            },
        },
    }
}

require('lspconfig')['yamlls'].setup {
    capabilities = capabilities,
    settings = {
        yaml = {
            schemas = {
                ["https://raw.githubusercontent.com/quantumblacklabs/kedro/develop/static/jsonschema/kedro-catalog-0.17.json"] = "conf/**/*catalog*",
                ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/*.k8s.yaml",
                ["http://json.schemastore.org/kustomization"] = "kustomization.yaml",
                ["https://raw.githubusercontent.com/GoogleContainerTools/skaffold/master/docs/content/en/schemas/v2beta8.json"] = "skaffold.yaml",
                ["https://azuremlschemas.azureedge.net/latest/pipelineJob.schema.json"] = "**/azure-pipelines.yml",
                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*"
            }
        }
    }
}
