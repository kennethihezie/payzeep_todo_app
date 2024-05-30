abstract class UseCase <I, O> {
  O invoke(I input);
}