
async function main() {
  const {default: A} = await import("./test.js")

  const modeToggleElm = document.getElementById('mode-toggle')! as HTMLInputElement;
  const inputElm = document.getElementById('text-input')! as HTMLInputElement;
  const outputElm = document.getElementById('text-output')! as HTMLInputElement;
  const errorElm = document.getElementById('error-log')! as HTMLTextAreaElement;

  inputElm.addEventListener('keyup', e => {
    try {
      if (modeToggleElm.checked) {
        outputElm.value = A.toBase32Str(inputElm.value);
      } else {
        outputElm.value = A.toBase10Str(inputElm.value);
      }
    } catch (e) {
      errorElm.value += `${new Date().getHours()}:${new Date().getMinutes()}:\t ${e}\n`;
    }
  });
}

main();
