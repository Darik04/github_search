
# GitHub Search app

GitHub Search project with GraphQL and REST APIs(two implementations)

## Guides

- Ability to change data provider(`REST/GraphQL`):
```dart
class MainConfigApp {
  ...

  static const DataSourceType dataSourceType = DataSourceType.graphQL;//or rest

  ...
}
```
- All credentials in one place
```dart
class CredentialsData{
    ...
}
```
