import SwiftUI

struct TaskInboxPlanView: View {
    @Binding var task: Task

    var body: some View {
        Z {
            Rectangle()
                .fill(Color(hex: 0xeeeeee))

            V {
                H {
                    Text(task.title)
                        .padding(.horizontal, 10)
                        .padding(.top, 6)

                    Spacer()
                }

                Spacer()

                H {
                    Text(task.date.formatted(Date.FormatStyle.custom))
                        .foregroundStyle(.gray)
                        .padding(.horizontal, 10)
                        .padding(.bottom, 6)
                        .font(.caption)

                    Spacer()
                }
            }
        }
        .cornerRadius(8)
    }
}

#Preview {
    TaskInboxPlanView(
        task: .constant(._stub)
    )
}
