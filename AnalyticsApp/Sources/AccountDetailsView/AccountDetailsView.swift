import AccountDetails
import ComposableArchitecture
import SwiftUI

public struct AccountDetailsView: View {
    @Environment(\.dismiss) var dismiss
    let store: StoreOf<AccountDetails>

    public init(store: StoreOf<AccountDetails>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            ZStack {
                Rectangle()
                    .foregroundStyle(Color.white)
                    .ignoresSafeArea(.all)
                VStack(alignment: .center, spacing: 0) {
                    navigationBar(viewStore)
                    icon
                    Text(viewStore.dataSource.name)
                        .font(.system(size: 24, weight: .medium))
                        .foregroundStyle(Color(.nameBlack))
                        .padding(.bottom, 4)
                    Text(viewStore.dataSource.description)
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(Color(.nameBlack).opacity(0.6))
                        .padding(.bottom, 24)
                    Text(viewStore.dataSource.getFormattedAmount())
                        .font(.system(size: 40, weight: .regular))
                        .foregroundStyle(Color(.nameBlack))
                    Spacer()
                }
            }
            .dismissDragGesture {
                dismiss()
            }
            .navigationBarBackButtonHidden()
        }
    }

    private func navigationBar(_ viewStore: ViewStoreOf<AccountDetails>) -> some View {
        HStack(alignment: .center, spacing: 0) {
            Button {
               dismiss()
            } label: {
                Image(.backArrow)
                    .frame(width: 24, height: 24)
            }
            Spacer()
            Text("Details")
                .font(.system(size: 17, weight: .semibold))
                .kerning(-0.5)
                .padding(.bottom, 13)
            Spacer()
            Rectangle()
                .foregroundStyle(Color.clear)
                .frame(width: 24, height: 24)
                .contentShape(Rectangle())
        }
        .padding(.horizontal, 14)
    }

    private var icon: some View {
        Circle()
            .frame(width: 80, height: 80)
            .foregroundStyle(Color(.logoGray))
            .overlay {
                Text("LOGO")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundStyle(Color.white)
            }
            .padding(.vertical, 24)
    }
}
