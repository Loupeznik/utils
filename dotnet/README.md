# Dotnet scripts

## Migration scripts

Provides Entity Framework migration scripts for manipulating migrations.

You will need to install the dotnet-ef tool to use these scripts.

### Usage

Place the `migration-scripts.ps1` file into a `scripts` directory under the root of your project.

Run the script with the following command:

```powershell
scripts\migration-scripts.ps1 -project <your_project_name> -action [add|remove|update] -name <migration_name>
```
