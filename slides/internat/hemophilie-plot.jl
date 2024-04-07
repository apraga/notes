using CairoMakie

x = [6.25, 12.5, 25, 50, 100]
y = (-1).*x .+ 80

fig, ax = lines(x, y)
scatter!(ax, x, y)
save("calibration.png", fig)

x2 = x[3:5]
y2 =(-1).*x[3:5] .+ 85
fig, ax = lines(x, y)
lines!(ax, x2, y2)
scatter!(ax, x, y)
scatter!(ax, x2, y2)
save("patient.png", fig)

x2[2] = x2[2]+18
fig, ax = lines(x, y)
lines!(ax, x2, y2)
scatter!(ax, x, y)
scatter!(ax, x2, y2)
save("acc.png", fig)
