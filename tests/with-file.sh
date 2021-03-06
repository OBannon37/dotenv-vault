source src/dotenv-vault.sh

set +eu

testcase_get_key_should_recognize_password_file() {
    echo foobarbaz > .dotenv-password

    assert_equal foobarbaz `dotenv-vault::get-key`

    rm .dotenv-password
}

testcase_with_file_should_same_with_env() {
    bin/dotenv-vault -k foobarbaz encrypt tests/assets/dotenv > /tmp/dotenv.encrypted

    echo foobarbaz > .dotenv-password

    bin/dotenv-vault -k foobarbaz decrypt /tmp/dotenv.encrypted > /tmp/dotenv.decrypted

    assert_true diff /tmp/dotenv.decrypted tests/assets/dotenv

    rm .dotenv-password
}
