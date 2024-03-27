import sys
import ruamel.yaml

def main():
    yaml_str = """\
    name:
      # details
      family Smith
      given: Alice
    """
    yaml = ruamel.yaml.YAML()  # defaults to round-trip if no parameters given
    code = yaml.load(yaml_str)
    for key in code['name'].lc.data:
        print(key)
    print(code['name'].ca.comment[1][0].value)


if __name__ == "__main__":
    main()